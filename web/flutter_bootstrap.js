{{flutter_js}}
{{flutter_build_config}}

const progressBar = document.getElementById('progress_bar');
const progressText = document.getElementById('progress_text');
const statusText = document.getElementById('status_text');
const loaderWrapper = document.getElementById('loading_indicator');

let currentPercent = 0;
let progressInterval;

function updateFakeProgress(targetPercent) {
  clearInterval(progressInterval);

  progressInterval = setInterval(() => {
    if (currentPercent < targetPercent) {
      currentPercent += 1;
      
      if (progressBar) progressBar.style.width = currentPercent + '%';
      if (progressText) progressText.textContent = currentPercent + '%';

      if (statusText) {
        if (currentPercent < 40) statusText.textContent = "Downloading engine...";
        else if (currentPercent < 80) statusText.textContent = "Preparing assets...";
        else if (currentPercent < 100) statusText.textContent = "Finalizing...";
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
  }, 10);
}

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    updateFakeProgress(75);
    const appRunner = await engineInitializer.initializeEngine();
    updateFakeProgress(85);
    await appRunner.runApp();
    updateFakeProgress(100);
  }
});