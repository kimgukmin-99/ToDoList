FROM python:3.11-buster

ENV PYTHONUNBUFFERED=1

WORKDIR /src

#pip로 poetry 설치
RUN pip install "poetry==1.6.1"

COPY pyproject.toml* poetry.lock* ./

RUN poetry config virtualenvs.in-project true

RUN if [-f pyproject.toml]; then poetry install --no-root; fi

ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]
