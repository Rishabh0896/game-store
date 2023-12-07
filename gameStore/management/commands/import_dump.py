from django.core.management.base import BaseCommand
from django.conf import settings
import mysql.connector
import os


def create_or_update_database_and_import_dump(self):
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
    mycursor.close()
    mydb.database = db_name

    db_dump_file = 'game_store_db_dump_v3.sql'
    sql_scripts_path = settings.BASE_DIR
    file_path = os.path.join(sql_scripts_path, db_dump_file)

    with open(file_path, 'r') as f:
        ddl_script = f.read()

    mycursordump = mydb.cursor()
    mycursordump.execute(ddl_script)

    mycursordump.close()
    mydb.commit()
    mydb.close()


class Command(BaseCommand):
    help = 'Create database and import Database Dump'

    def handle(self, *args, **options):
        create_or_update_database_and_import_dump(self)

        self.stdout.write(self.style.SUCCESS('Database dump imported successfully'))
