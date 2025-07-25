print(
    """
-----------------------------------------------------------------
✨ Hello Tilt! This appears in the (Tiltfile) pane whenever Tilt
   evaluates this file.
-----------------------------------------------------------------
""".strip()
)

load("ext://syncback", "syncback")

docker_build(
    "backend",
    context="backend",
    build_args={"DEVEL": "yes", "TEST": "yes"},
    live_update=[
        sync("./backend/config", "/app/src/config"),
        sync("./backend/rochescaf", "/app/src/rochescaf"),
    ],
)


docker_build(
    "frontend",
    context="frontend",
    live_update=[
        sync("./frontend", "/app"),
    ],
)


k8s_yaml(
    kustomize("./k8s/local/")
)

syncback(
    "backend-sync",
    "deploy/backend",
    "/app/src/rochescaf/",
    target_dir="./backend/rochescaf",
    rsync_path='/app/bin/rsync.tilt',
)


syncback(
    "frontend-sync",
    "deploy/frontend",
    "/app/",
    target_dir="./frontend",
    rsync_path='/app/rsync.tilt',
    ignore=[".next", "next-env.d.ts", "node_modules", "rsync.tilt"],
)



k8s_resource(workload='frontend', port_forwards=3000)

k8s_resource(workload='backend', port_forwards=8000)
k8s_resource(workload='mailhog', port_forwards=8025)
k8s_resource(workload='postgres', port_forwards=5432)

