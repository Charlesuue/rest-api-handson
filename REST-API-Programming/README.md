# Flask MySQL API with XML and JSON Support

This Flask application provides a RESTful API to interact with a MySQL database. It supports basic authentication and can return responses in both JSON and XML formats. The application includes endpoints to manage customer data.

## Prerequisites

- Python 3.11
- MySQL server or MySQL Workbench
- Virtual environment (recommended)

## Installation

1. **Clone the repository:**
   ```sh
   git clone <repository_url>
   cd <repository_directory>

2. Create and activate a virtual environment:

python -m venv venv
source venv/bin/activate  # On Windows use: venv\Scripts\activate

3. Install dependencies:

pip install -r requirements.txt

4. Set up MySQL database:

Ensure your MySQL server is running.
Create the database and necessary tables. The configuration in this application assumes a database named "mung_beans_final".

Running the Application

1. Run the Flask application:

python main2.py

2. Access the application:

The application will be accessible at http://127.0.0.1:5000/.

API Endpoints

Authentication
The application uses basic authentication. Use the following credentials:

- Username: charles
- Password: 9999

Endpoints
Get all customers
- URL: /customer
- Method: GET
- Authentication: Required
- Response format: JSON (default) or XML

Get customer by ID
- URL: /customer/<int:id>
- Method: GET
- Authentication: Required
- Response format: JSON (default) or XML

Get customer satisfaction by customer ID
- URL: /customer/<int:id>/customer_satisfaction
- Method: GET
- Authentication: Required
- Response format: JSON (default) or XML

Add a new customer
- URL: /customer
- Method: POST
- Authentication: Required
- Request body: JSON
- Response format: JSON (default) or XML

Update a customer by ID
- URL: /customer/<int:id>
- Method: PUT
- Authentication: Required
- Request body: JSON
- Response format: JSON (default) or XML

Delete a customer by ID
- URL: /customer/<int:id>
- Method: DELETE
- Authentication: Required
- Response format: JSON (default) or XML



### Additional Notes

1. **Database Schema:** Ensure your MySQL database schema matches the queries used in the code.
2. **Error Handling:** The current implementation has basic error handling. You may want to enhance it as needed.
3. **Dependencies:** Make sure to create a `requirements.txt` file with the necessary dependencies if it doesn't already exist.

To generate the `requirements.txt` file, you can use:

```sh
pip freeze > requirements.txt


