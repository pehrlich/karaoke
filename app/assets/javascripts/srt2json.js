srt2json = {
  parseTime: function(string) {
    var res = string.match(/(\d\d):(\d\d):(\d\d),(\d\d\d)/);
    return parseInt(res[2], 10) * 60 + parseInt(res[3], 10) + parseInt(res[4], 10) / 1000; // seconds
  },
  parseTimeRow: function(string) {
    var res = string.match(/(.*)\s--\>\s(.*)/);
    return({
      begin: this.parseTime(res[1]),
      end: this.parseTime(res[2])
    });
  },parseSubBlok: function(string) {
    var res = string.match(/\n?\d*\n(.*)\n(.*)(\n)*/);
    block = {
      text: res[2],
      time: this.parseTimeRow(res[1])
    }
    return block;
  },
  parse: function(string) {
    o = this;
    blocks = string.split("\n\n");
    res = [];
    $.each(blocks, function(index, value) {
      res.push(o.parseSubBlok(value));
    });
    return res;
  }
}
