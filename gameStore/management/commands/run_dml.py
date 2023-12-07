from django.core.management.base import BaseCommand
from django.db import connection
from django.conf import settings

import os


class Command(BaseCommand):
    help = 'Execute DML scripts'

    def handle(self, *args, **options):
        dml_files = ['django_dml.sql', 'dml.sql']

        sql_scripts_path = settings.BASE_DIR / 'sql_scripts/'

        for dml_file in dml_files:
            file_path = os.path.join(sql_scripts_path, dml_file)
            with open(file_path, 'r') as f:
                dml_script = f.read()
                with connection.cursor() as cursor:
                    cursor.execute(dml_script)

        self.stdout.write(self.style.SUCCESS('DML scripts executed successfully'))
