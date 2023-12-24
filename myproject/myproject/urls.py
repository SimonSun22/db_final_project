from django.contrib import admin
from django.urls import include, path
from myapp.views import add_customer  

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', add_customer, name='root'),  
    path('add-customer/', include('myapp.urls')),  
]
