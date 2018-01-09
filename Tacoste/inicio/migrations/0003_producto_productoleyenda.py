# Generated by Django 2.0.1 on 2018-01-08 04:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('inicio', '0002_auto_20180108_0418'),
    ]

    operations = [
        migrations.CreateModel(
            name='Producto',
            fields=[
                ('idproducto', models.BigIntegerField(primary_key=True, serialize=False)),
                ('puntosotorgar', models.BigIntegerField(blank=True, null=True)),
                ('nombre', models.CharField(blank=True, max_length=70, null=True)),
                ('precio', models.FloatField(blank=True, null=True)),
                ('taquegoria', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'producto',
                'managed': True,
            },
        ),
        migrations.CreateModel(
            name='Productoleyenda',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('leyenda', models.CharField(blank=True, max_length=50, null=True)),
                ('idproducto', models.ForeignKey(db_column='idproducto', on_delete=django.db.models.deletion.DO_NOTHING, to='inicio.Producto')),
            ],
            options={
                'db_table': 'productoleyenda',
                'managed': True,
            },
        ),
    ]