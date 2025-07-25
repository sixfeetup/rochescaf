import pytest
from strawberry_django.test.client import TestClient

from rochescaf.users.models import User
from rochescaf.users.tests.factories import UserFactory


@pytest.fixture(autouse=True)
def media_storage(settings, tmpdir):
    settings.MEDIA_ROOT = tmpdir.strpath


@pytest.fixture
def user() -> User:
    return UserFactory()


@pytest.fixture
def graphql_client() -> TestClient:
    return TestClient("/graphql/")
