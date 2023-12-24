from datetime import datetime
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.contrib import messages
import os
from django.conf import settings
import pandas as pd
from .models import Customer, CustomerAddress
import joblib

def load_ml_models():
    linear_model_path = os.path.join(settings.BASE_DIR, 'ml_models', 'linear_model.pkl')
    gender_encoder_path = os.path.join(settings.BASE_DIR, 'ml_models', 'Gender_encoder.pkl')
    city_encoder_path = os.path.join(settings.BASE_DIR, 'ml_models', 'City_encoder.pkl')
    chronic_disease_encoder_path = os.path.join(settings.BASE_DIR, 'ml_models', 'Chronic Disease_encoder.pkl')

    linear_model = joblib.load(linear_model_path)
    label_encoders = {
        'Gender': joblib.load(gender_encoder_path),
        'City': joblib.load(city_encoder_path),
        'Chronic Disease': joblib.load(chronic_disease_encoder_path)
    }

    return linear_model, label_encoders

linear_model, label_encoders = load_ml_models()

def add_customer(request):
    form_submitted = False
    if request.method == "POST":
        try:
            ssn = request.POST.get('ssn')
            first_name = request.POST.get('first_name')
            last_name = request.POST.get('last_name')
            dob = datetime.strptime(request.POST.get('dob'), '%Y-%m-%d').date()
            gender = request.POST.get('gender') == 'Male'
            age = int(request.POST.get('age'))
            heredity = bool(int(request.POST.get('heredity')))
            income = int(request.POST.get('income'))
            unhealthy_eating = bool(int(request.POST.get('unhealthy_eating')))
            smoking_drinking = bool(int(request.POST.get('smoking_drinking')))
            chronic_disease = request.POST.get('chronic_disease')
            city = request.POST.get('city')

            new_customer = Customer(
                Gender=gender,
                SSN=ssn,
                CusLastName=last_name,
                CusFirstName=first_name,
                CusDOB=dob,
                Age=age,
                Heredity=heredity,
                Income=income,
                UnhealthyEatingHabit=unhealthy_eating,
                SmokingAndDrinking=smoking_drinking,
                TypicalChronicDiseases=chronic_disease,
            )
            new_customer.save()

            new_address = CustomerAddress(
                SSN=new_customer,
                CustCity=city,
            )
            new_address.save()

            form_submitted = True
            messages.success(request, "Customer added successfully.")
        except ValueError as e:
            messages.error(request, f"Error in form submission: {e}")
        except Exception as e:
            messages.error(request, "An unexpected error occurred. Please try again.")

        return redirect('add_customer')

    return render(request, 'add_customer.html', {'form_submitted': form_submitted})


def calculate_quote(request):
    if request.method == "POST":
        try:
            gender = request.POST.get('gender')
            city = request.POST.get('city')
            chronic_disease = request.POST.get('chronic_disease')
            age = int(request.POST.get('age')) if request.POST.get('age') else 0
            heredity = bool(int(request.POST.get('heredity'))) if request.POST.get('heredity') else False
            income = int(request.POST.get('income')) if request.POST.get('income') else 0
            smoking_and_drinking = bool(int(request.POST.get('smoking_drinking'))) if request.POST.get('smoking_drinking') else False
            unhealthy_eating = bool(int(request.POST.get('unhealthy_eating'))) if request.POST.get('unhealthy_eating') else False

            if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                column_names = [
                    'Gender', 'City', 'Age', 'Heredity', 'Income', 
                    'Unhealthy Eating', 'Smoking and Drinking', 'Chronic Disease'
                ]

                processed_data = {
                    'Gender': label_encoders['Gender'].transform([gender])[0] if gender else None,
                    'City': label_encoders['City'].transform([city])[0] if city else None,
                    'Chronic Disease': label_encoders['Chronic Disease'].transform([chronic_disease])[0] if chronic_disease else None,
                    'Age': age,
                    'Heredity': heredity,
                    'Income': income,
                    'Unhealthy Eating': unhealthy_eating,
                    'Smoking and Drinking': smoking_and_drinking
                }
                data_for_prediction = pd.DataFrame([processed_data], columns=column_names)

                predicted_price = linear_model.predict(data_for_prediction)

                return JsonResponse({'quote': f"Calculated Insurance Quote: ${predicted_price[0]:.2f}"})
            else:
                pass

        except ValueError as e:
            error_message = f"Error in data processing: {e}"
        except Exception as e:
            error_message = "An unexpected error occurred during quote calculation. Please try again."

        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return JsonResponse({'error': error_message}, status=400)
        else:
            messages.error(request, error_message)
            return redirect('add_customer')

    return render(request, 'add_customer.html')
