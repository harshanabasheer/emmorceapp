# Generated by Django 4.2.6 on 2023-11-10 09:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerceapp', '0009_categorytb_categoryimage'),
    ]

    operations = [
        migrations.AddField(
            model_name='wishlisttb',
            name='ProductImage',
            field=models.ImageField(null=True, upload_to='images/'),
        ),
    ]
