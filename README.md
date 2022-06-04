# sklearn-flask-docker

Wdrożenie modelu sklearn przy użyciu "Flask" + przy użyciu kontenera "Docker".

## Kroki:

## 1. Trenowanie modelu
Aby wytrenować nowy model, należy uruchomić to:

`python train.py`

Outputem jest model pikle w pliku o nazwie `model.pkl`.

## 2. Budowa obrazu Docker

Skonstruowanie obrazu (`docker build`) o nazwie chrisalbon/sklearn-flask-docker (`--tag chrisalbon/sklearn-flask-docker`) z Dockerfile (`.`).

Konstrukcja tego obrazu jest określona przez `Dockerfile`.

`docker build --tag chrisalbon/sklearn-flask-docker .`

## 3. Budowa kontenera z obrazu Docker

Stwórz i rozpocznij (`docker run`) jako (`-d`) Kontener Docker o nazwie sklearn-flask-docker (`--name sklearn-flask-docker`) z obrazu `chrisalbon/sklearn-flask-docker:latest` gdzie port maszyny hosta jest połączony z portem 3333 kontenera Docker (`-p 3000:3333`).

`docker run -p 3000:3333 -d --name sklearn-flask-docker chrisalbon/sklearn-flask-docker:latest`

## 4. Zapytanie Prediction API z przykładową obserwacją

Ponieważ nasz model jest szkolony na zestawie danych zabawek Iris, możemy przetestować API, wysyłając zapytanie o przewidywaną klasę dla tej przykładowej obserwacji:

- sepal length = 4.5
- sepal width = 2.3
- petal length = 1.3
- petal width = 0.3

### W przeglądarce

Należy wkleić ten adres URL do paska przeglądarki:

`http://0.0.0.0:3000/api/v1.0/predict?sl=4.5&sw=2.3&pl=1.3&pw=0.3`

W przeglądarce powinno to wyglądać w następujący sposób:
```
{"features":[4.5,2.3,1.3,0.3],"predicted_class":0}
```

`"predicted_class":0` oznacza, że przewidywana klasa to "Iris setosa"

### Za pomocą Curl

Należy wkleić ten adres URL do paska przeglądarki:

`curl -i "0.0.0.0:3000/api/v1.0/predict?sl=4.5&sw=2.3&pl=1.3&pw=0.3"`

W przeglądarce powinno to wyglądać w następujący sposób:
```
HTTP/1.0 200 OK
Content-Type: application/json
Content-Length: 51
Server: Werkzeug/1.0.1 Python/3.6.12
Date: Tue, 25 Aug 2020 20:29:41 GMT

{"features":[4.5,2.3,1.3,0.3],"predicted_class":0}
```

## Podstawowe operacje Docker

Będzie trzeba użyć `sudo` dla tych poleceń, jednak najlepszą praktyką jest dodanie użytkownika do `docker` grupy podczas pracy w środowisku produkcyjnym.

### Uruchomienie kontenera

`docker start sklearn-flask-docker`

### Zatrzymanie kontenera

`docker stop sklearn-flask-docker`

### Żeby usunąć kontener

`docker rm sklearn-flask-docker`
