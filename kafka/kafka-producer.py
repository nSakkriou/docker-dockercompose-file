from confluent_kafka import Producer
import socket, time

conf = {'bootstrap.servers': 'localhost:29092',
        'client.id': socket.gethostname()}

producer = Producer(conf)

while True:
        producer.produce("quickstart-events", key="key", value="value")
        time.sleep(1)
        
producer.flush()