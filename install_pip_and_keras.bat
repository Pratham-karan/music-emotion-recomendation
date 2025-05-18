@echo off
REM Download get-pip.py
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

REM Install pip in the virtual environment
e:/india_naik/Emotion-Music-Recommendation-main/Emotion-Music-Recommendation-main/.venv/Scripts/python.exe get-pip.py

REM Install keras using the newly installed pip
e:/india_naik/Emotion-Music-Recommendation-main/Emotion-Music-Recommendation-main/.venv/Scripts/python.exe -m pip install keras

REM Clean up
del get-pip.py

echo Pip and Keras installation completed in the virtual environment.
pause
