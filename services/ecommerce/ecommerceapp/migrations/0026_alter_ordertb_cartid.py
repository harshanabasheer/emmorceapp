# Generated by Django 4.2.6 on 2023-11-24 07:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerceapp', '0025_carttb_itemcheck'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ordertb',
            name='CartId',
            field=models.CharField(blank=True, default=1, max_length=50),
            preserve_default=False,
        ),
    ]
