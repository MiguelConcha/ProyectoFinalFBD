# Generated by Django 2.0.1 on 2018-01-09 02:44

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('inicio', '0004_cliente'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cliente',
            name='user',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]