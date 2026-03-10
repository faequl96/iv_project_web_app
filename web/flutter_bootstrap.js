{{flutter_js}}
{{flutter_build_config}}

const progressBar = document.getElementById('progress_bar');
const progressText = document.getElementById('progress_text');
const statusText = document.getElementById('status_text');
const loaderWrapper = document.getElementById('loading_indicator');

let currentPercent = 0;
let progressInterval;
let pendingResolve;

window.updateSplashProgress = function(initialPercent, targetPercent, intervalInMs) {
  if (pendingResolve) {
    pendingResolve();
    console.log('log on: ', initialPercent);
    pendingResolve = null;
  }

  return new Promise((resolve) => {
    pendingResolve = resolve;
    
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
          else if (currentPercent < 96) statusText.textContent = "Downloading Assets...";
          else if (currentPercent < 100) statusText.textContent = "Preparing Assets...";
          else statusText.textContent = "Launching App...";
        }
      } else {
        clearInterval(progressInterval);
        const finishResolve = pendingResolve;
        pendingResolve = null;

        if (currentPercent >= 100 && loaderWrapper) {
          setTimeout(() => {
            loaderWrapper.style.opacity = '0';
            setTimeout(() => {
              if (loaderWrapper.parentNode) loaderWrapper.remove();
              if (finishResolve) {
                finishResolve();
                console.log('log on: ', initialPercent);
              }
            }, 200);
          }, 400);
        } else {
          if (finishResolve) {
            finishResolve();
            console.log('log on: ', initialPercent);
          }
        }
      }
    }, intervalInMs);
  });
}

updateSplashProgress(0, 50, 100);

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    updateSplashProgress(50, 60, 120);
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
  }
});