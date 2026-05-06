import pytest
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_index(client):
    assert client.get('/').status_code == 200

def test_login_fail(client):
    assert client.post('/login', data={'login':'x','password':'x'}, follow_redirects=True).status_code == 200

def test_cakes(client):
    assert client.get('/cakes').status_code == 200

def test_page(client):
    assert client.get('/cakes/1').status_code == 200

def test_search(client):
    assert client.get('/cakes?search=торт').status_code == 200

def test_logout(client):
    assert client.get('/logout', follow_redirects=True).status_code == 200
