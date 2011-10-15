$(document).ready(function() {
    var API_KEY = '5959221';
    var TOKEN = 'moderator_token';
    var recorderManager;
    var recorder;
    var player;

    TB.setLogLevel(TB.DEBUG);

    recorderManager = TB.initRecorderManager(API_KEY);
  
    function exceptionHandler(event) {
        alert("Exception:" + event.title + ". " + event.message); 
    }
  
    function archiveSavedHandler(event) {
        var archiveId = event.archives[0].archiveId;
        console.log(archiveId);
    }

    function showRecorder() {
        var properties = { width: '800', height: '450' };
        recorder = recorderManager.displayRecorder(TOKEN, 'opentok_recorder', properties);
    }

    function showPlayer(archiveId) {
        var properties = { width: '400', height: '225' };
        player = recorderManager.displayPlayer(TOKEN, 'opentok_player', properties);
    }
    
});

