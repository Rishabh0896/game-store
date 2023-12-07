from django.core.management.base import BaseCommand
from django.db import connection
from django.conf import settings
import mysql.connector
import os


def create_database():
    database_settings = settings.DATABASES['default']
    db_user = database_settings['USER']
    db_password = database_settings['PASSWORD']
    db_host = database_settings['HOST']
    db_name = database_settings['NAME']
    mydb = mysql.connector.connect(
        host=db_host,
        user=db_user,
        password=db_password
    )
    mycursor = mydb.cursor()
    mycursor.execute(f"CREATE DATABASE IF NOT EXISTS {db_name}")


class Command(BaseCommand):
    help = 'Execute DDL scripts'

    def handle(self, *args, **options):
        create_database()
        ddl_files = ['django_ddl.sql', 'ddl.sql']

        sql_scripts_path = settings.BASE_DIR / 'sql_scripts/'

        for ddl_file in ddl_files:
            file_path = os.path.join(sql_scripts_path, ddl_file)
            with open(file_path, 'r') as f:
                ddl_script = f.read()
                with connection.cursor() as cursor:
                    cursor.execute(ddl_script)

        self.stdout.write(self.style.SUCCESS('DDL scripts executed successfully'))
