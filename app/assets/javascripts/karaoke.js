$(document).ready(function() {
  var API_KEY = '5933671l';
  var TOKEN = 'moderator_token';
  var recorderManager;
  var recorder;
  var player;
  var archive;
  var recordPane;
  var myArchives = new Object();

  TB.setLogLevel(TB.DEBUG);

  myArchives.archive1 = archive1;
  myArchives.archive2 = archive2;

  recorderManager = TB.initRecorderManager(API_KEY);

  // video container div
  var video1Container = document.createElement('div');
  video1Container.setAttribute('id', 'video1Container');
  // div that will be replaced by first video
  var video1Div = document.createElement('div');
  video1Div.setAttribute('id', 'video1');
  $('#main').append(video1Container);
  $('#' + video1Container.id).append(video1Div);

  var video2Container = document.createElement('div');
  video2Container.setAttribute('id', 'video2Container');
  var video2Div = document.createElement('div');
  video2Div.setAttribute('id', 'video2');
  $('#main').append(video2Container);
  $('#' + video2Container.id).append(video2Div);

  // use myArchives.length instead?
  if (!myArchives.archive1 && !myArchives.archive2) {
    // new project
    console.log('new project');
    recordPane = 1;
    recorder = recorderManager.displayRecorder(TOKEN, 'video1');
    recorder.addEventListener('archiveSaved', archiveSavedHandler);
  }
  else if (myArchives.archive1 && !myArchives.archive2) {
    // One existing archive
    recordPane = 2;
    player = recorderManager.displayPlayer(archive1, TOKEN, 'video1');
    recorder = recorderManager.displayRecorder(TOKEN, 'video2');
    recorder.addEventListener('archiveSaved', archiveSavedHandler);
  }
  else if (myArchives.archive1 && myArchives.archive2) {
    player = recorderManager.displayPlayer(archive1, TOKEN, 'video1');
    player2 = recorderManager.displayPlayer(archive2, TOKEN, 'video2');
    player.addEventListener('playbackStarted', playbackStartedHandler);
  }
  else {
    alert('Problem with archive logic!');
  }

  TB.addEventListener("exception", exceptionHandler);

  function exceptionHandler(event) {
    alert("Exception:" + event.title + ". " + event.message);
  }

  function archiveSavedHandler(event) {
    archiveId = event.archives[0].archiveId;

    //switch this to case statment
    // determine which archive ID and DOM element to set by which pane was recorded from
    if (recordPane == 1) {
      myArchives.archive1 = archiveId;
      elem = 'video1'
    }
    if (recordPane == 2) {
      myArchives.archive2 = archiveId;
      elem = 'video2'
    }

    saveArchive(projectId, archiveId, elem);
  }

  function saveArchive(projectId, archiveId, elem) {
    // Save archiveID to server
    $.ajax({
      url: '/saveArchiveData',
      type: 'POST',
//		    dataType: 'json',
      data: { 'myArchives': myArchives, 'projectId': projectId },
      error: function(data) {
        alert('error');
      },
      success: function(data) {
        alert('success!');
        // remove recorder, add temp video div for player to appropriate container
        if (elem == 'video1') {
          recorderManager.removeRecorder(recorder);

          var video1Div = document.createElement('div');
          video1Div.setAttribute('id', 'video1');
          $('#main').append(video1Container);
          $('#' + video1Container.id).append(video1Div);

          myArchives.archive1 = archiveId;
          recordPane = 2;
          player = recorderManager.displayPlayer(archiveId, TOKEN, elem);
          recorder = recorderManager.displayRecorder(TOKEN, 'video2');
          recorder.addEventListener('archiveSaved', archiveSavedHandler);
        }
        if (elem == 'video2') {
          recorderManager.removeRecorder(recorder);

          var video2Div = document.createElement('div');
          video2Div.setAttribute('id', 'video2');
          $('#main').append(video2Container);
          $('#' + video2Container.id).append(video2Div);

          myArchives.archive2 = archiveId;
          player2 = recorderManager.displayPlayer(archiveId, TOKEN, elem);
        }
      }
    });
  }
});

function playbackStartedHandler(event) {
  player2.startPlayback();
}











