// Thanks https://stackoverflow.com/a/31732310
let isSafari = navigator.vendor && navigator.vendor.indexOf('Apple') > -1 &&
  navigator.userAgent &&
  navigator.userAgent.indexOf('CriOS') == -1 &&
  navigator.userAgent.indexOf('FxiOS') == -1;

isSafari && window.location.replace("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
