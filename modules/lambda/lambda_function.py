import json
import pymysql
import os

# Get database credentials from environment variables
DB_HOST = os.environ['DB_HOST']
DB_USER = os.environ['DB_USER']
DB_PASSWORD = os.environ['DB_PASSWORD']
DB_NAME = os.environ['DB_NAME']

def lambda_handler(event, context):
    try:
        # Connect to MySQL
        connection = pymysql.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME,
            cursorclass=pymysql.cursors.DictCursor
        )

        with connection.cursor() as cursor:
            # Create table if it doesn't exist
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS messages (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    message VARCHAR(255) NOT NULL
                );
            """)

            # Check if the table is empty
            cursor.execute("SELECT COUNT(*) AS count FROM messages;")
            result = cursor.fetchone()
            if result["count"] == 0:
                # Insert "Hello World" if empty
                cursor.execute("INSERT INTO messages (message) VALUES ('Hello World');")
                connection.commit()

            # Fetch "Hello World" from the database
            cursor.execute("SELECT message FROM messages LIMIT 1;")
            message_result = cursor.fetchone()

        connection.close()

        # Return API response
        return {
            "statusCode": 200,
            "body": json.dumps(message_result['message']) if message_result else "No message found"
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps(f"Error: {str(e)}")
        }
