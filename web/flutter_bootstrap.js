{{flutter_js}}
{{flutter_build_config}}

const progressBar = document.getElementById('progress_bar');
const progressText = document.getElementById('progress_text');
const statusText = document.getElementById('status_text');
const loaderWrapper = document.getElementById('loading_indicator');

let currentPercent = 0;
let progressInterval;

function updateFakeProgress(initialPercent, targetPercent) {
  clearInterval(progressInterval);

  currentPercent = initialPercent;

  progressInterval = setInterval(() => {
    if (currentPercent < targetPercent) {
      currentPercent += 1;
      
      if (progressBar) progressBar.style.width = currentPercent + '%';
      if (progressText) progressText.textContent = currentPercent + '%';

      if (statusText) {
        if (currentPercent < 50) statusText.textContent = "Downloading Environment...";
        else if (currentPercent < 60) statusText.textContent = "Preparing Environment...";
        else if (currentPercent < 90) statusText.textContent = "Downloading Assets...";
        else if (currentPercent < 100) statusText.textContent = "Preparing Assets...";
        else statusText.textContent = "Launching App...";
      }
    } else {
      clearInterval(progressInterval);
      if (currentPercent >= 100 && loaderWrapper) {
        setTimeout(() => {
          loaderWrapper.style.opacity = '0';
          setTimeout(() => loaderWrapper.remove(), 400);
        }, 200);
      }
    }
  }, 80);
}

window.removeSplash = function() {
  const loaderWrapper = document.getElementById('loading_indicator');
  if (loaderWrapper) {
    if (typeof updateFakeProgress === 'function') updateFakeProgress(90, 100);
    
    loaderWrapper.style.opacity = '0';
    setTimeout(() => loaderWrapper.remove(), 1000);
  }
};

updateFakeProgress(0, 50);

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    updateFakeProgress(50, 60);
    const appRunner = await engineInitializer.initializeEngine();
    updateFakeProgress(60, 90);
    await appRunner.runApp();
  }
});