{{flutter_js}}
{{flutter_build_config}}

const progressBar = document.getElementById('progress_bar');
const progressText = document.getElementById('progress_text');
const statusText = document.getElementById('status_text');
const loaderWrapper = document.getElementById('loading_indicator');

let currentPercent = 0;
let progressInterval;

window.updateSplashProgress = function(initialPercent, targetPercent) {
  clearInterval(progressInterval);

  currentPercent = initialPercent;

  progressInterval = setInterval(() => {
    if (currentPercent < targetPercent) {
      currentPercent += 1;
      
      if (progressBar) progressBar.style.width = currentPercent + '%';
      if (progressText) progressText.textContent = currentPercent + '%';

      if (statusText) {
        if (currentPercent < 51) statusText.textContent = "Downloading Environment...";
        else if (currentPercent < 61) statusText.textContent = "Preparing Environment...";
        else if (currentPercent < 91) statusText.textContent = "Downloading Assets...";
        else if (currentPercent < 100) statusText.textContent = "Preparing Assets...";
        else statusText.textContent = "Launching App...";
      }
    } else {
      clearInterval(progressInterval);
      console.log(currentPercent);
      if (currentPercent >= 100 && loaderWrapper) {
        console.log('is100', currentPercent);
        setTimeout(() => {
          loaderWrapper.style.opacity = '0';
          setTimeout(() => loaderWrapper.remove(), 200);
        }, 400);
      }
    }
  }, 80);
}

updateSplashProgress(0, 50);

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    updateSplashProgress(50, 60);
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
  }
});