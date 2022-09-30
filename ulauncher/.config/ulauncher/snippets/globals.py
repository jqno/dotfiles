import uuid


def generate_random_uuid():
    return str(uuid.uuid4())


globals = {
    "generate_random_uuid": generate_random_uuid()
}
