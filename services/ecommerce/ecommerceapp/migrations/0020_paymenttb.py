# Generated by Django 4.2.6 on 2023-11-18 05:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerceapp', '0019_alter_ordertb_cartid'),
    ]

    operations = [
        migrations.CreateModel(
            name='PaymentTb',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('UserId', models.CharField(max_length=50)),
                ('TotalAmount', models.CharField(max_length=50)),
                ('PaymentMethod', models.CharField(max_length=50)),
                ('OrderId', models.CharField(max_length=50)),
                ('PaymentStatus', models.CharField(max_length=50)),
            ],
        ),
    ]