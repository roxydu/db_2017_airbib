$.ajaxSetup({'cache':true});
var baseUrl = 'https://ec2-54-242-86-211.compute-1.amazonaws.com:4000/?';

var variable_one = '';
var variable_two = '';

var first = () => {
    variable_one = document.getElementById('amenities_choice_one').value;
    variable_two = document.getElementById('tf').value;
    if(validateFirst(variable_one + '&' + variable_two)) {
        var url = baseUrl + 'A&' + variable_one + '&' + variable_two + '?' + 'first_catch';
        console.log(url);
        $.getScript(url);
    } else {
        window.alert('wrong input, check your inputs');
    }

}

var validateFirst = (data) => {
    variable_one = data.split('&')[0];
    variable_two = data.split('&')[1];
    console.log(variable_one, variable_two);
    if((variable_one === 'wifi' ||
            variable_one === 'parking' ||
            variable_one === 'kitchen' ||
            variable_one === 'pet_friendly' ||
            variable_one === 'washer' ||
            variable_one === 'dryer') && (
            variable_two === 'False' ||
            variable_two === 'True')) {
        return true;
    }
    return false;
}

var first_catch = (data) => {
    console.log(data);
    var sum = 0;
    var count = 0;
    var html = 'The average rating for homes ';
    html += (variable_two === 'True')? 'with ': 'without ';
    html += variable_one;
    data.forEach((datum)=>{
        console.log(datum.stars);
        sum += parseInt(datum.stars);
        count++;
    });
    html += ': <b>' + (sum / count) + '</b>';
    $('#basket').html(html);
}

var second = () => {
    variable_one = document.getElementById('amenities_choice_two').value;
    if(validateSecond(variable_one)) {
        var url = baseUrl + 'B&' + variable_one + '?' + 'second_catch';
        console.log(url);
        $.getScript(url);
    } else {
        window.alert('wrong input, check your inputs');
    }

}

var validateSecond = (data) => {
    variable_one = data;
    console.log(variable_one);
    if(variable_one === 'wifi' ||
            variable_one === 'parking' ||
            variable_one === 'kitchen' ||
            variable_one === 'pet_friendly' ||
            variable_one === 'washer' ||
            variable_one === 'dryer') {
        return true;
    }
    return false;
}

var second_catch = (data) => {
    var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var monthRepeat = [false, false, false, false, false, false, false, false, false, false, false, false];
    console.log(JSON.stringify(data));
    var html = '<h3>The homes without ' + variable_one + ' are still able to be rent out in the following months: </h3>';
    data.forEach((datum)=>{
        var monthNumber = parseInt(datum['month(Reservation.checkInDate)']) - 1;
        if(!monthRepeat[monthNumber]) {
            monthRepeat[monthNumber] = true;
            html += '<h4>' + monthNames[monthNumber] + '</h4>';
        }

    });
    $('#basket').html(html);
}

var third = () => {
    var url = baseUrl + 'C' + '?' + 'third_catch';
    console.log(url);
    $.getScript(url);
}

var third_catch = (data) => {
    console.log(JSON.stringify(data));
    var html = ' <table class="text-center" style="width:100%"><tr><th>Billed Amount ($)</th><th>Host Name</th></tr>';
    data.forEach((datum)=>{
        html += '<tr><th>' + datum['Sum(Reservation.billAmount)'] + '</th><th>' + datum.hostName + '</th></tr>';
    });
    html += '</table>';
    $('#basket').html(html);
}
