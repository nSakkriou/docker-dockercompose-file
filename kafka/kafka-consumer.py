from kafka import KafkaConsumer

consumer = KafkaConsumer("quickstart-events", bootstrap_servers='localhost:29092')
for message in consumer:
    print(message)