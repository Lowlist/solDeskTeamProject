    //맵 관련 로직
    $(document).ready(function(){
        let mapId = $('.medium-center-right-map').attr('id');
        // var mapOptions = {
        //     center: new naver.maps.LatLng(37.3595704, 127.105399),
        //     zoom: 10
        // }
        // var marker = new naver.maps.Marker(mapId,{
        //     position: new naver.maps.LatLng(37.3595704, 127.105399),
        //     map: map
        // });
        // 맵 불러오는 기본로직
        // var map = new naver.maps.Map(mapId,{
        //     center: new naver.maps.LatLng(37.3595704, 127.105399),
        //     zoom: 6
        // });
        var cityhall = new naver.maps.LatLng(36.4967235, 127.9238804);

        var map = new naver.maps.Map(mapId, {
                center: cityhall,
                zoom: 7
            });
        var marker = new naver.maps.Marker({
                map: map,
                position: cityhall
            });
        var contentString = [
                '<div class="">',
                '?',
                '</div>'
            ].join('');

        var infowindow = new naver.maps.InfoWindow({
            content: contentString
        });
        
        infowindow.open(map, marker);

        window.navermap_authFailure = function () {
            console.log("인증실패했음");
        }
        $("#mapBtn0").css('background-color', 'blue');
        $("#mapBtn0").css('color', 'white');
        //맵 버튼 로직
        $('.map-btn').click(function (){
            // 모든 버튼에 대한 스타일 초기화
            $('.map-btn').css({
                'background-color': 'white',
                'color': 'black'
            });
            // 클릭한 버튼의 스타일 변경
            $(this).css({
                'background-color': 'blue',
                'color': 'white'
            });
            // 버튼 액션
        });

    });