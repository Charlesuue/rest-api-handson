from flask import Flask, make_response, jsonify, request
from flask_mysqldb import MySQL
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, get_jwt_identity
from flask_bcrypt import Bcrypt
from flask_httpauth import HTTPBasicAuth

app = Flask(__name__)

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "root"
app.config["MYSQL_DB"] = "mung_beans_final"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

#app.config["JWT_SECRET_KEY"] = "super-secret"  

mysql = MySQL(app)
bcrypt = Bcrypt(app)
auth = HTTPBasicAuth()

#jwt = JWTManager(app)


# Verify password function
@auth.verify_password
def verify_password(username, password):
    return username == "charles" and password == "9898"


def data_fetch(query):
    cur = mysql.connection.cursor()
    cur.execute(query)
    data = cur.fetchall()
    cur.close()
    return data


@app.route("/")
@auth.login_required
def hello_world():
    return "<p>Hello, World!</p>"


@app.route("/customer", methods=["GET"])
@auth.login_required  # Requires authentication
def get_customer():
    data = data_fetch("""select * from customer""")
    return make_response(jsonify(data), 200)


@app.route("/customer/<int:id>", methods=["GET"])
@auth.login_required  # Requires authentication
def get_customer_by_id(id):
    data = data_fetch("""SELECT * FROM customer where id_Customer = {}""".format(id))
    return make_response(jsonify(data), 200)


@app.route("/customer/<int:id>/customer_satisfaction", methods=["GET"])
@auth.login_required  # Requires authentication
def get_customer_by_id_Customer(id):
    data = data_fetch(
        """
       SELECT customer.id_Customer, customer_satisfaction.rate
        FROM customer
        INNER JOIN customer_satisfaction
        ON customer.id_Customer = customer_satisfaction.rate
        WHERE customer.id_Customer = {}""".format(id))

    return make_response(
        jsonify({"id_Customer": id, "count": len(data), "rate": data}), 200
    )


@app.route("/customer", methods=["POST"])
@auth.login_required  # Requires authentication
def add_customer():
    if not request.is_json:
        return jsonify({"message": "Missing JSON in request"}), 400

    info = request.get_json()
    id_Customer = info["id_Customer"]
    Last_name = info["Last_name"]
    First_name = info["First_name"]
    Contact_No = info["Contact_No"]
    Email = info["Email"]
    Location = info["Location"]
    Password = bcrypt.generate_password_hash(info["Password"]).decode('utf-8')

    cur = mysql.connection.cursor()
    cur.execute(
        """ INSERT INTO customer (id_Customer, Last_name, First_name, Contact_No, Email, Location, Password) 
        VALUES (%s, %s, %s, %s, %s, %s, %s)""",
        (id_Customer, Last_name, First_name, Contact_No, Email, Location, Password))
    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(
        jsonify({"message": "customer added successfully", "rows_affected": rows_affected}),
        201
    )


@app.route("/customer/<int:id>", methods=["PUT"])
@auth.login_required  # Requires authentication
def update_customer(id):
    if not request.is_json:
        return jsonify({"message": "Missing JSON in request"}), 400

    info = request.get_json()
    Last_name = info["Last_name"]
    First_name = info["First_name"]
    Contact_No = info["Contact_No"]
    Email = info["Email"]
    Location = info["Location"]
    Password = bcrypt.generate_password_hash(info["Password"]).decode('utf-8')

    cur = mysql.connection.cursor()
    cur.execute(
        """ UPDATE customer SET Last_name = %s, First_name = %s, Contact_No = %s, Email = %s, 
        Location = %s, Password = %s WHERE id_Customer = %s """,
        (Last_name, First_name, Contact_No, Email, Location, Password, id),
    )
    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(
        jsonify({"message": "Customer updated successfully", "rows_affected": rows_affected}),
        200,
    )


@app.route("/customer/<int:id>", methods=["DELETE"])
@auth.login_required  # Requires authentication
def delete_customer(id):
    cur = mysql.connection.cursor()
    cur.execute(""" DELETE FROM customer where id_Customer = %s """, (id,))
    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(
        jsonify({"message": "customer deleted successfully", "rows_affected": rows_affected}),
        200,
    )


@app.route("/login", methods=["POST"])
def login():
    if not request.is_json:
        return jsonify({"message": "Missing JSON in request"}), 400

    username = request.json.get("username", None)
    password = request.json.get("password", None)

    if not username:
        return jsonify({"message": "Missing username parameter"}), 400
    if not password:
        return jsonify({"message": "Missing password parameter"}), 400

    # Check username and password against database
    # Example:
    # user = User.query.filter_by(username=username).first()
    # if not user or not bcrypt.check_password_hash(user.password, password):
    #     return jsonify({"message": "Bad username or password"}), 401

    # For demonstration, create an access token
    access_token = create_access_token(identity=username)
    return jsonify(access_token=access_token), 200


@app.route("/customer/format", methods=["GET"])
@auth.login_required  # Requires authentication
def get_params():
    fmt = request.args.get('id')
    foo = request.args.get('aaaa')
    return make_response(jsonify({"format": fmt, "foo": foo}), 200)



if __name__ == "__main__":
    app.run(debug=True)
