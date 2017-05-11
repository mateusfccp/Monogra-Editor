var gulp = require('gulp');

var concat = require('gulp-concat');
var cleanCSS = require('gulp-clean-css');
var elm = require('gulp-elm');
var nodemon = require('gulp-nodemon');
var rename = require('gulp-rename');
var runSequence = require('run-sequence');
var sass = require('gulp-sass');

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

gulp.task('sass', function() {
    return gulp.src('src/sass/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('src/css'));
});

gulp.task('css', ['sass'], function() {
    return gulp.src(['src/css/**/reboot.css', 'src/css/**/basscss.css', 'src/css/**/*.css'])
        .pipe(concat('style.css'))
        .pipe(cleanCSS({
            level: {
                2: {
                    mergeAdjacentRules: true, // controls adjacent rules merging; defaults to true
                    mergeIntoShorthands: true, // controls merging properties into shorthands; defaults to true
                    mergeMedia: true, // controls `@media` merging; defaults to true
                    mergeNonAdjacentRules: true, // controls non-adjacent rule merging; defaults to true
                    mergeSemantically: false, // controls semantic merging; defaults to false
                    overrideProperties: true, // controls property overriding based on understandability; defaults to true
                    removeEmpty: true, // controls removing empty rules and nested blocks; defaults to `true`
                    reduceNonAdjacentRules: true, // controls non-adjacent rule reducing; defaults to true
                    removeDuplicateFontRules: true, // controls duplicate `@font-face` removing; defaults to true
                    removeDuplicateMediaBlocks: true, // controls duplicate `@media` removing; defaults to true
                    removeDuplicateRules: true, // controls duplicate rules removing; defaults to true
                    removeUnusedAtRules: false, // controls unused at rule removing; defaults to false (available since 4.1.0)
                    restructureRules: false, // controls rule restructuring; defaults to false
                    skipProperties: [] // controls which properties won't be optimized, defaults to `[]` which means all will be optimized (since 4.1.0)
                }
            }
        }))
        .pipe(gulp.dest('public/dist/'));
});

gulp.task('build-css', function(callback) {
    runSequence('sass', 'css');
});

gulp.task('build', ['elm-bundle', 'build-css']);

gulp.task('serve-json', function() {
    nodemon({ script: 'api.js' });
})

gulp.task('debug-server', ['build', 'serve-json'], function() {
    var elm_watcher = gulp.watch('src/elm/**/*.elm', ['elm-bundle']);
    var css_watcher = gulp.watch('src/css/**/*.css', ['build-css']);
    var sass_watcher = gulp.watch('src/sass/**/*.scss', ['build-css']);
    elm_watcher.on('change', function(event) {
        console.log('Elm Watcher: File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
    css_watcher.on('change', function(event) {
        console.log('CSS Watcher: File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
    sass_watcher.on('change', function(event) {
        console.log('Sass Watcher: File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
})