var gm = require('gm');

gm('./images/abc.jpg')
.resize(353, 257)
.autoOrient()
.write(writeStream, function (err) {
  if (!err) console.log(' hooray! ');
});
