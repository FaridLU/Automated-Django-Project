project_name=$1

if [ -z "$project_name" ]; then
	echo ERROR: Project Name is not provided
	exit 0
fi


echo '*** Install required package of pip *** '
apt install python3-pip
pip3 install virtualenv 

echo '*** Installing Django globally ***'
pip3 install Django

echo '*** Create Django Project ***'
mkdir ~/Desktop/Django\ Projects/$project_name
django-admin startproject $project_name ~/Desktop/Django\ Projects/$project_name && sleep 3


echo '*** Setup "static" file settings  ***'
mkdir ~/Desktop/Django\ Projects/$project_name/static
cp -r MDBootstrap/* ~/Desktop/Django\ Projects/$project_name/static
cat extra_settings.txt >> ~/Desktop/Django\ Projects/$project_name/$project_name/settings.py

echo '*** Make templates directory ***'
mkdir ~/Desktop/Django\ Projects/templates
cp base.html ~/Desktop/Django\ Projects/templates

echo '*** Update templates directory ***'
sed -i "s/'DIRS':\ \[],/'DIRS':\ \[os.path.join(BASE_DIR, 'templates')],/g" ~/Desktop/Django\ Projects/farid/farid/settings.py

echo '*** Go to project directory ***'
cd ~/Desktop/Django\ Projects/$project_name

echo '*** Create virtualenv ***'
python3 -m venv venv

echo '*** Activate virtualenv ***'
source venv/bin/activate && sleep 2

echo '*** Install esential packages of python ***'
pip install Django 					# For running Django projects
pip install django-crispy-forms		# For using good looking forms
pip install djangorestframework		# For using Django Rest Framework
pip install markdown       			# Markdown support for the browsable API.
pip install django-filter  			# Filtering support

pip freeze > requirements.txt

echo '*** Making migrations ***'
python3 manage.py makemigrations && sleep 5
python3 manage.py migrate && sleep 5

python3 manage.py createsuperuser

python3 manage.py runserver 0:8000

echo 'Done'
