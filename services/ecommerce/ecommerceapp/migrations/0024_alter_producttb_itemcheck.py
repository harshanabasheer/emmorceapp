# Generated by Django 4.2.6 on 2023-11-20 06:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerceapp', '0023_producttb_itemcheck'),
    ]

    operations = [
        migrations.AlterField(
            model_name='producttb',
            name='ItemCheck',
            field=models.CharField(default=1, max_length=50),
            preserve_default=False,
        ),
    ]