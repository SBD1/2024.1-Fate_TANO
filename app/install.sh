create_docker_db() {
    echo "Subindo Docker..."

    docker compose up -d
}

delete_docker_dp() {
    echo "Removendo Docker..."

    docker compose down
}

# Verificando argumento
if [[ $1 == "instalar" ]]; then
    create_docker_db
elif [[ $1 == "desinstalar" ]]; then
    delete_docker_dp
else
    echo "Uso: $0 {instalar|desinstalar}"
fi