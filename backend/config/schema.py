import strawberry
from strawberry_django.optimizer import DjangoOptimizerExtension

from rochescaf.users.mutations import UserMutation
from rochescaf.users.queries import UserQuery

schema = strawberry.Schema(
    query=UserQuery,
    mutation=UserMutation,
    extensions=[
        # other extensions...
        DjangoOptimizerExtension,
    ],
)
