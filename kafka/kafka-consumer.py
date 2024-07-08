from confluent_kafka import Consumer

conf = {'bootstrap.servers': 'localhost:29092',
        'group.id': 'foo',
        'auto.offset.reset': 'smallest'}

consumer = Consumer(conf)
consumer.subscribe(["quickstart-events"])
while True:
    msg = consumer.poll(timeout=1.0)
    if msg is None: continue
    else:
        print(str(msg.message))