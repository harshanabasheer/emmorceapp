# Generated by Django 4.2.6 on 2023-10-25 06:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerceapp', '0003_carttb'),
    ]

    operations = [
        migrations.AddField(
            model_name='producttb',
            name='ProductImage',
            field=models.ImageField(null=True, upload_to='images/'),
        ),
    ]
