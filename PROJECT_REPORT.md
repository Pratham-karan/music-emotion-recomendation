# Project Report: Emotion-Based Music Recommendation System

## 1. Introduction
The Emotion-Based Music Recommendation System is designed to enhance user experience by recommending music tracks based on the user's current emotional state. Utilizing real-time facial emotion recognition through a webcam, the system identifies the user's emotion and suggests appropriate music from curated Spotify playlists. This integration of computer vision, deep learning, and music streaming APIs creates a personalized and interactive music recommendation platform.

## 2. System Components and Workflow

### 2.1 Emotion Detection Module
The core of the emotion detection module is a Convolutional Neural Network (CNN) trained to classify facial expressions into seven categories: Angry, Disgusted, Fearful, Happy, Neutral, Sad, and Surprised.

- **Model Architecture:** The CNN consists of multiple convolutional layers with ReLU activations, max-pooling layers to reduce spatial dimensions, dropout layers to prevent overfitting, and fully connected dense layers culminating in a softmax output layer for multi-class classification.
- **Training Process:** The model is trained on grayscale facial images resized to 48x48 pixels. Training and validation datasets are loaded using Keras ImageDataGenerator from designated directories. The model is optimized using categorical crossentropy loss and the Adam optimizer. Trained weights are saved for inference.
- **Real-Time Detection:** Using OpenCV, the system captures video frames from the webcam. Faces are detected using Haar cascades, and each detected face is preprocessed and passed through the CNN to predict the emotion. The predicted emotion is then used to update the system's state.

### 2.2 Music Recommendation Module
This module maps detected emotions to music recommendations sourced from Spotify playlists.

- **Spotify API Integration:** The Spotify API is integrated in the `Spotipy.py` file using the Spotipy Python library. This file contains functions to authenticate with Spotify, fetch track IDs and details from emotion-specific playlists, and save this data as CSV files in the `songs/` directory. These CSV files are then used at runtime for quick music recommendations without making live API calls.
- **Data Preparation:** Track information is periodically fetched and stored as CSV files categorized by emotion. This offline data storage enables quick access during runtime.
- **Recommendation Logic:** Based on the current detected emotion, the system reads the relevant CSV file and selects the top 15 tracks to recommend to the user.

### 2.3 Web Application Interface
The user interacts with the system through a Flask-based web application.

- **Backend:** The Flask app serves the main page displaying music recommendations and streams the webcam video feed with emotion annotations. It exposes endpoints for the video stream and music data in JSON format.
- **Frontend:** The interface presents the live video feed alongside a table listing recommended songs with their names, albums, and artists. Styling is managed through CSS in the static directory.

### 2.4 Performance Enhancements
To maintain smooth video streaming and responsive emotion detection, the system employs multithreading.

- **Threaded Video Capture:** A dedicated thread continuously reads frames from the webcam, reducing latency and improving frame rates.
- **Efficient Data Handling:** Music recommendations are updated dynamically without interrupting the video stream.

## 3. Code Interconnection Flow Chart

```mermaid
flowchart TD
    A[app.py] -->|Imports| B[camera.py]
    A -->|Uses music_rec()| C[Spotipy.py]
    B -->|Uses| D[utils.py]
    B -->|Loads model weights| E[model.h5 / new_model_64p35.h5]
    B -->|Reads CSV files| F[songs/*.csv]
    C -->|Fetches playlists and creates| F
    D -->|Provides threaded video capture| B
    G[train.py] -->|Trains model and saves weights| E
    A -->|Serves web interface| H[templates/index.html & static/css]
```

## 4. Conclusion
The Emotion-Based Music Recommendation System successfully integrates real-time emotion recognition with personalized music suggestions, providing an engaging user experience. The modular design allows for easy updates to the emotion model or music playlists. Performance optimizations ensure the system operates smoothly in real-time, making it suitable for interactive applications.

This report outlines the architecture, components, and workflow of the system, offering a comprehensive understanding of its operation and capabilities.
