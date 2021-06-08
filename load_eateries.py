import db
import json

# import SQLAlchemy
dsn = db.generate_dsn('config.json')
print(dsn)
session = db.get_session(dsn)
with open('src/DPR_Eateries_001.json', "r") as f:
    files = json.load(f)
lissy = []
for file in files:
    e = db.Eatery()
    e.name = file['name']
    e.location = file['location']
    e.park_id = file['park_id']
    e.start_date = file['start_date']
    e.end_date = file['end_date']
    e.description = file['description']
    e.permit_number = file['permit_number']
    e.phone = file['phone']
    e.website = file['website']
    e.type_name = file['type_name']
    lissy.append(e)
session.add_all(lissy)
session.commit()
# print(lissy)


