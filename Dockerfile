

#base image 
FROM python:3.9

#Sets /app as the current directory inside the container. 
WORKDIR /app

# Copies requirements.txt from your local machine into /app , The . means “copy into the current working directory”
COPY  requirements.txt .

# Ensures you’re using the latest version of pip
RUN python -m pip install --upgrade pip

#Installs all Python packages listed in requirements.txt
RUN pip install -r requirements.txt

#Copies everything from your project directory into /app
COPY . .


#Container listens on port 8000.
EXPOSE 8000


#This is the command that runs when the container starts.
# Start the Uvicorn web server
# Look inside app/main.py and use the variable "app"
# Listen on all network interfaces (required for Docker access)
# Run on port 8000 inside the container
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

