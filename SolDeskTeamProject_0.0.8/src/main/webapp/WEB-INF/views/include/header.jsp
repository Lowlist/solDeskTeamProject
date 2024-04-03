<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<!-- 메인 홈 톱 시작 -->
        <div class="main-home-top-line">
            <div class="home-top-icon-line">
                <div class="home-top-icon" id="homeTopIconImg"></div>
                <div class="home-top-icon" id="homeTopIconWord">기상정보공유사이트</div>
            </div>
            <div class="home-top-menu-line">
                <!-- 좌측부터 1번으로 시작함 -->
                <c:forEach var="i" begin="0" end="2">
                	<div class="home-top-menu-word" id="homeTopMenuWord${i}"></div>
                </c:forEach>
            </div>
        </div>
        <!-- 메인 홈 톱 끝 -->
        <!-- 메인 홈 하이 시작 -->
        <div class="main-home-high-line">
            <div class="home-high-icon-line" id="homeHighImg">
            	<div id="homeHighIcon"></div>
            </div>
            <div class="home-high-serach-line">
                <div class="home-high-left-serach-line">
                    <form action="" method="get" class="home-serach-form">
                        <input type="text" value="'관측'을 검색하세요" id="homeSearchWord">
                        <input type="submit" id="homeSearchBtn" data-searchMain="">
                    </form>
                </div>
                <div class="home-high-right-serach-line">
                    <div class="home-high-right-popular-serach-line">
	                    <c:forEach var="i" begin="0" end="9">
	                    	<div class="home-popular-serach" id="homePopularSerach${i}"></div>
	                	</c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <!-- 메인 홈 하이 끝 -->
        <!-- 메인 홈 헤더 시작 -->
        <div class="main-home-header-line">
        	<c:forEach var="i" begin="0" end="4">
        		<div class="home-header-menu" id="homeHeaderMenu${i}">
        		</div>
	        </c:forEach>
	        <div class="main-home-popup-line">
				<div class="home-popup-line-1">
					<div class="home-popup-word-1"></div>
				</div>
				<div class="home-popup-line-2">
					<div class="home-popup-word-2"></div>
				</div>
				<div class="home-popup-line-3">
					<div class="home-popup-word-3"></div>
				</div>
				<div class="home-popup-line-4">
					<div class="home-popup-word-4"></div>
				</div>
			</div>
        </div>
        <!-- 메인 홈 헤더 끝 -->