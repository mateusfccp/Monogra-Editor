var gulp = require('gulp');

var concat = require('gulp-concat');
var elm = require('gulp-elm');
var cleanCSS = require('gulp-clean-css');
var nodemon = require('gulp-nodemon');
var rename = require('gulp-rename');

// Elm related

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], function() {
    return gulp.src('src/elm/**/*.elm')
        .pipe(elm())
        .pipe(gulp.dest('public/dist/'));
});

gulp.task('elm-bundle', ['elm-init'], function() {
    return gulp.src('src/elm/**/*.elm')
        .pipe(elm.bundle('bundle.js'))
        .on('error', function(error) {
            console.log(error.toString());
            this.emit('end');
        })
        .pipe(rename('app.js'))
        .pipe(gulp.dest('public/dist/'));
});

// CSS related

gulp.task('css-bundle', function() {
    return gulp.src('src/css/**/*.css')
        .pipe(concat('style.css'))
        .pipe(cleanCSS())
        .pipe(gulp.dest('public/dist/'));
});

gulp.task('build', ['elm-bundle', 'css-bundle']);

gulp.task('serve-json', function() {
    nodemon({ script: 'api.js' });
})

gulp.task('debug-server', ['build', 'serve-json'], function() {
    var elm_watcher = gulp.watch('src/elm/**/*.elm', ['elm-bundle'])
    var css_watcher = gulp.watch('src/css/**/*.css', ['css-bundle']);
    elm_watcher.on('change', function(event) {
        console.log('Elm Watcher: File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
    css_watcher.on('change', function(event) {
        console.log('CSS Watcher: File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
})