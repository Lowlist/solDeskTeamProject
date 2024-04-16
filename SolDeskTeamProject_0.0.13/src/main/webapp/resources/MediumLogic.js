    //맵 관련 로직
    $(document).ready(function(){
        let mapId = $('.medium-center-right-map').attr('id');
        var cityhall = new naver.maps.LatLng(36.4967235, 127.9238804);

        var map = new naver.maps.Map(mapId, {
                center: cityhall,
                zoom: 7
            });
        //마커
        // var marker = new naver.maps.Marker({
        //         map: map,
        //         position: cityhall
        //     });
        var contentString = [
                '<div class="">',
                // '?',
                '</div>'
            ].join('');

        var infowindow = new naver.maps.InfoWindow({
            content: contentString
        });
        //,marker가 map옆에 있었음
        infowindow.open(map);

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

        

        function dfs_xy_conv(code, v1, v2) {
            let DEGRAD = Math.PI / 180.0;
            let RADDEG = 180.0 / Math.PI;
        
            let re = RE / GRID;
            let slat1 = SLAT1 * DEGRAD;
            let slat2 = SLAT2 * DEGRAD;
            let olon = OLON * DEGRAD;
            let olat = OLAT * DEGRAD;
        
            let sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
            sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
            let sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
            sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
            let ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
            ro = re * sf / Math.pow(ro, sn);
            let rs = {};
            if (code == "toXY") {
                rs['lat'] = v1;
                rs['lng'] = v2;
                let ra = Math.tan(Math.PI * 0.25 + (v1) * DEGRAD * 0.5);
                ra = re * sf / Math.pow(ra, sn);
                let theta = v2 * DEGRAD - olon;
                if (theta > Math.PI) theta -= 2.0 * Math.PI;
                if (theta < -Math.PI) theta += 2.0 * Math.PI;
                theta *= sn;
                rs['x'] = Math.floor(ra * Math.sin(theta) + XO + 0.5);
                rs['y'] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
            }
            else {
                rs['x'] = v1;
                rs['y'] = v2;
                let xn = v1 - XO;
                let yn = ro - v2 + YO;
                ra = Math.sqrt(xn * xn + yn * yn);
                if (sn < 0.0) - ra;
                let alat = Math.pow((re * sf / ra), (1.0 / sn));
                alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;
        
                if (Math.abs(xn) <= 0.0) {
                    theta = 0.0;
                }
                else {
                    if (Math.abs(yn) <= 0.0) {
                        theta = Math.PI * 0.5;
                        if (xn < 0.0) - theta;
                    }
                    else theta = Math.atan2(xn, yn);
                }
                let alon = theta / sn + olon;
                rs['lat'] = alat * RADDEG;
                rs['lng'] = alon * RADDEG;
            }
            return rs;
        }
        
        function nowDate() {
            const today = new Date();
            const year = today.getFullYear();
            let month = today.getMonth() + 1;
            let day = today.getDate();
        
            if (month < 10) {
                month = '0' + month;
            }
            if (day < 10) {
                day = '0' + day;
            }
            return `${year}${month}${day}`;
        }

    });