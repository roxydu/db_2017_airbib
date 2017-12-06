$.ajaxSetup({'cache':true});
var baseUrl = 'https://ec2-54-242-86-211.compute-1.amazonaws.com:4000/?';

var first = () => {
    var variable_one = document.getElementById('amenities_choice_one').value;
    var variable_two = document.getElementById('tf').value;
    if(validateFirst(variable_one + '&' + variable_two)) {
        var url = baseUrl + 'A&' + variable_one + '&' + variable_two + '?' + 'first_catch';
        console.log(url);
        $.getScript(url);
    } else {
        window.alert('wrong input, check your inputs');
    }

}

var validateFirst = (data) => {
    var variable_one = data.split('&')[0];
    var variable_two = data.split('&')[1];
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
    data.forEach((datum)=>{
        console.log(datum.stars);
        sum += parseInt(datum.stars);
        count++;
    });
    $('#basket').html('The average is: <b>' + (sum / count) + '</b>');
}

var second = () => {
    var variable_one = document.getElementById('amenities_choice_two').value;
    if(validateSecond(variable_one)) {
        var url = baseUrl + 'B&' + variable_one + '?' + 'second_catch';
        console.log(url);
        $.getScript(url);
    } else {
        window.alert('wrong input, check your inputs');
    }

}

var validateSecond = (data) => {
    var variable_one = data;
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
    console.log(JSON.stringify(data));
    var html = '';
    data.forEach((datum)=>{
        html += '<h4>' + datum.checkInDate.split('T')[0] + '</h4>';
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
    var html = ' <table class="text-center" style="width:100%">';
    data.forEach((datum)=>{
        html += '<tr><th>' + datum.billAmount + '</th><th>' + datum.hostName + '</th></tr>';
    });
    html += '</table>';
    $('#basket').html(html);
}
