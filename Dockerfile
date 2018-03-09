# <WARNING>
# Everything within sections like <TAG> is generated and can
# be automatically replaced on deployment. You can disable
# this functionality by simply removing the wrapping tags.
# </WARNING>

# <DOCKER_FROM>
FROM aldryn/base-project:3.0.0
# </DOCKER_FROM>

# <NPM>
# </NPM>

# <BOWER>
# </BOWER>

# <PYTHON>
RUN mkdir -p ~/.pip && printf "[global]\nindex-url = https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM:-aldryn-baseproject}/+simple/\nfind-links=\n    file:///root/.cache/pip-tools/wheels\n    file:///root/.cache/pip-tools/pkgs\nretries = 11\n" > ~/.pip/pip.conf
COPY requirements.in /app/
COPY addons-dev /app/addons-dev/
RUN pip-compile -v
RUN pip install \
    --no-deps \
    --requirement requirements.txt
# </PYTHON>

# <SOURCE>
COPY . /app
# </SOURCE>

# <GULP>
# </GULP>

# <STATIC>
RUN DJANGO_MODE=build python manage.py collectstatic --noinput
# </STATIC>
