project_name=$1
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
NC=$(tput sgr0) #No color

if [ -z "$project_name" ]; then
	echo ERROR: ${RED}Project Name is not provided
	exit 0
fi

echo "***${GREEN} Install required package of pip ${NC}***"
apt install python3-pip
pip3 install virtualenv 

echo "***${GREEN} Installing Django globally ${NC}***"
pip3 install Django

echo "***${GREEN} Create Django Project ${NC}***"
mkdir ~/Desktop/Django\ Projects/$project_name
django-admin startproject $project_name ~/Desktop/Django\ Projects/$project_name && sleep 3


echo "***${GREEN} Setup "static" file settings  ${NC}***"
mkdir ~/Desktop/Django\ Projects/$project_name/static
cp -r MDBootstrap/* ~/Desktop/Django\ Projects/$project_name/static
cat extra_settings.txt >> ~/Desktop/Django\ Projects/$project_name/$project_name/settings.py

echo "***${GREEN} Make templates directory ${NC}***"
mkdir ~/Desktop/Django\ Projects/templates
cp base.html ~/Desktop/Django\ Projects/templates

echo "***${GREEN} Update templates directory ${NC}***"
sed -i "s/"DIRS":\ \[],/"DIRS":\ \[os.path.join(BASE_DIR, "templates")],/g" ~/Desktop/Django\ Projects/farid/farid/settings.py

echo "***${GREEN} Go to project directory ${NC}***"
cd ~/Desktop/Django\ Projects/$project_name

echo "***${GREEN} Create virtualenv ${NC}***"
python3 -m venv venv

echo "***${GREEN} Activate virtualenv ${NC}***"
source venv/bin/activate && sleep 2

echo "***${GREEN} Install esential packages of python ${NC}***"
pip install Django 					# For running Django projects
pip install django-crispy-forms		# For using good looking forms
pip install djangorestframework		# For using Django Rest Framework
pip install markdown       			# Markdown support for the browsable API.
pip install django-filter  			# Filtering support

pip freeze > requirements.txt

echo "***${GREEN} Making migrations ${NC}***"
python3 manage.py makemigrations && sleep 5
# python3 manage.py migrate && sleep 5

python3 manage.py createsuperuser

python3 manage.py runserver 0:8000

echo "${NC}Done"
