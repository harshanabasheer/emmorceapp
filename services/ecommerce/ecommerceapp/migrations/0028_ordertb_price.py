# Generated by Django 4.2.6 on 2023-11-29 06:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerceapp', '0027_alter_ordertb_cartid'),
    ]

    operations = [
        migrations.AddField(
            model_name='ordertb',
            name='Price',
            field=models.CharField(default=1, max_length=50),
            preserve_default=False,
        ),
    ]