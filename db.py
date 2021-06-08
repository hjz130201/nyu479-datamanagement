import json
import sqlalchemy
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from sqlalchemy import Column, Integer, String, DateTime, Date
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from datetime import datetime

def generate_dsn(filepath):
    # pass
    with open(filepath, "r") as f:
        file = json.load(f)
    username = file['username']
    password = file['password']
    database = file['database']
    dsn = f'postgresql://{username}:{password}@localhost/{database}'
    #res = 'postgresql://'+file['username']+':'+file['password']+'@localhost/'+file['database']
    return dsn

def get_session(dsn):
    # pass
    engine = create_engine(dsn, echo=True)
    Session = sessionmaker(engine)
    session = Session()
    return session
    # Session = sessionmaker()

Base = declarative_base()
class Eatery(Base):
    __tablename__ = 'eatery'
    
    eatery_id = Column('eatery_id', Integer, primary_key=True)
    name = Column('name', String)
    location = Column('location', String)
    park_id = Column('park_id', String)
    start_date = Column('start_date', DateTime(timezone=True))
    end_date = Column('end_date', DateTime(timezone=True))
    description = Column('description', String)
    permit_number = Column('permit_number', String)
    phone = Column('phone', String)
    website = Column('website', String)
    type_name = Column('type_name', String)
    # notes = relationship(Note) # match w/ Note for one-to-many 
    
    def __repr__(self):
        return f'{self.eatery_id} - {self.name} - {self.park_id}: {self.start_date} to {self.end_date} in {self.location} - {self.description} - {self.permit_number} - {self.phone} - {self.website} - {self.type_name}'
    
    def __str__(self):
        return self.__repr__()

