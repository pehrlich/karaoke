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


window.showRecorder = function() {
  var properties = { width: '800', height: '450' };
  recorder = recorderManager.displayRecorder(TOKEN, 'opentok_recorder', properties);

  recorder.addEventListener('archiveSaved', function(event) {
    var archiveId = event.archives[0].archiveId;
    console.log('archive saved', archiveId);

    $("#jam_new_archive_id").val(archiveId)

    $("#save_jam").submit();
  });
}

window.saveArchive = function(){
  recorder.saveArchive();

}

window.showPlayer = function(archiveId, elem_id) {
  var properties = { width: '364', height: '205' };
  player = recorderManager.displayPlayer(archiveId, TOKEN, elem_id, properties);
}
