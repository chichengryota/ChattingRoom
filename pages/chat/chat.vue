<template>
	<view>
		<navbar :type="2" :title="friendName" :showMenu="true" @clickMenu="goFriendDetail"></navbar>
		<scroll-view scroll-y="true">
			<view class="chat">
				<view class="chat-item" v-for="(item,index) in messageList" :key="index">
					<view class="chat-time" v-if="index<messageList.length-1">{{showTime(messageList[index].time,messageList[index+1].time) | filtedate}}</view>
					<view class="friend-message" v-if="!item.isSelf">
						<image :src="friendAvatar" mode="" class="avatar"></image>
						<view class="message" v-if="item.message">{{item.message}}</view>
						<image :src="item.img" mode="widthFix" class="image" v-else></image>
					</view>
					<view class="my-message" v-else>
						<view class="message" v-if="item.message">{{item.message}}</view>
						<image :src="item.img" mode="widthFix" class="image" v-else></image>
						<image :src="myAvatar" mode="" class="avatar"></image>
					</view>
				</view>
			</view>
		</scroll-view>
		<view class="send" ref="sendBox">
			<view class="send-box">
				<image src="../../static/image/voice.png" mode="widthFix" class="send-voice" v-show="isVoice" @click="isVoice=!isVoice"></image>
				<image src="../../static/image/keyboard.png" mode="widthFix" class="send-voice" v-show="!isVoice" @click="isVoice=!isVoice"></image>
				<input type="text" v-model="sendValue" v-show="isVoice" class="send-input"/>
				<text v-show="!isVoice" class="voice-box send-input">按住说话</text>
				<image src="../../static/image/emoji.png" mode="widthFix" class="send-add" @click="showEmoji"></image>
				<image src="../../static/image/add.png" mode="widthFix" class="send-add" @click="showOther"></image>
			</view>
			<view class="emoji-box" v-show="isEmoji">
			</view>
			<view class="other-box" v-show="isOther">
				<view class="other-item" v-for="(item,index) in otherImg" :key="index">
					<view class="other-img-content">
						<image :src="item.url" mode="widthFix" class="other-img"></image>
					</view>
					<text class="other-text">{{item.name}}</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import { formatDate } from '@/static/js/dateFormat.js';
	export default {
		data() {
			return {
				friendName:'李元芳',
				friendAvatar:'http://browser9.qhimg.com/bdm/720_450_85/t01fdcd6377a309b28b.jpg',
				myAvatar:'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
				myMessage: [{
					time: 1614689155857,
					message: '爱得起多群',
					isSelf: true
				},{
					time: 1614689855857,
					message: '阿达暗的地方玩法',
					isSelf: true
				}],
				friendMessage: [{
					time: 1614689695801,
					message: '是第三方三法师·',
					isSelf: false
				},{
					time: 1614689695857,
					message: '萨达·市场擦拭时·',
					isSelf: false
				},{
					time: 1614689615837,
					img: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
					isSelf: false
				},{
					time: 1614689925837,
					img: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
					isSelf: false
				},{
					time: 1614681615837,
					img: 'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
					isSelf: false
				}],
				messageList:[],
				isVoice: true,
				sendValue:'',
				isEmoji: false,
				isOther: false,
				id: null,
				otherImg:[{url:'../../static/image/photo.png',name:'图片'},{url:'../../static/image/camera.png',name:'拍摄'},{url:'../../static/image/map.png',name:'位置'},{url:'../../static/image/video.png',name:'视频'},{url:'../../static/image/file.png',name:'文件'}]
			}
		},
		computed:{
			showTime(){
				return (time1,time2)=>{
					if(time2-time1>120000){
						return time2
					}else{
						return null
					}
				}
			}
		},
		onLoad(option) {
			this.id = option.id
			this.handleMessage();
		},
		methods: {
			goFriendDetail(){
				uni.$u.route('/pages/friendDetail/friendDetail', { id: this.id });
			},
			handleMessage(){
				let tempArr = [];
				tempArr = this.myMessage.concat(this.friendMessage);
				function compare(property){
					return function(a,b){
						var value1 = a[property];
						var value2 = b[property];
						return value1 - value2;
					}
				}
				this.messageList = tempArr.sort(compare('time'))
				console.log(this.messageList);
			},
			showEmoji(){
				this.isOther = false;
				this.isEmoji = !this.isEmoji;
			},
			showOther(){
				this.isEmoji = false;
				this.isOther = !this.isOther;
			}
		},
		filters: {
			filtedate: function(date) {
				if(!date) return
				let t = new Date(date);
				return formatDate(t, 2);
			}
		}
	}
</script>

<style lang="scss" scoped>
.chat{
	padding-top: 50rpx;
	padding-bottom: 150rpx;
	background-color: #eee;
	.chat-item{
		.chat-time{
			text-align: center;
			font-size: 12px;
			color: #555;
		}
		.friend-message{
			display: flex;
			justify-content: flex-start;
			width: 100%;
			box-sizing: border-box;
			padding: 30rpx;
			.avatar{
				width: 80rpx;
				height: 80rpx;
				border-radius: 8px;
				margin-right: 30rpx;
			}
			.message{
				text-align: left;
				margin-top: 20rpx;
				max-width: 440rpx;
				padding: 10rpx 20rpx;
				border-radius: 6px;
				border-top-left-radius: 0;
				background-color: $theme-color;
			}
			.image{
				max-width: 440rpx;
				border-radius: 6px;
				margin-top: 20rpx;
			}
		}
		.my-message{
			display: flex;
			justify-content: flex-end;
			width: 100%;
			box-sizing: border-box;
			padding: 30rpx;
			.avatar{
				width: 80rpx;
				height: 80rpx;
				border-radius: 8px;
				margin-left: 20rpx;
			}
			.message{
				text-align: right;
				margin-top: 20rpx;
				max-width: 440rpx;
				padding: 10rpx 20rpx;
				border-radius: 6px;
				border-top-right-radius: 0;
				background-color: #fff;
			}
		}
	}
}
.send{
	width: 100%;
	position: fixed;
	bottom: 0;
	background-color: #eee;
	border-top: 1px solid #bbb;
	padding-bottom: 30rpx;
	.send-box{
		display: flex;
		height: 90rpx;
		align-items: center;
		justify-content: space-between;
		padding: 0 30rpx;
		box-sizing: border-box;
		.send-voice{
			width: 50rpx;
		}
		.send-input{
			background-color: #fff;
			border-radius: 5px;
			width: 400rpx;
			height: 64rpx;
			padding: 0 20rpx;
		}
		.voice-box{
			text-align: center;
			line-height: 60rpx;
		}
		.send-add{
			width: 50rpx;
		}
	}
	.emoji-box{
		width: 100%;
		height: 330rpx;
		background-color: #fff;
	}
	.other-box{
		width: 100%;
		height: 330rpx;
		display: flex;
		flex-wrap: wrap;
		padding: 0 15rpx;
		border-top: 1px solid #bbb;
		padding-top: 10rpx;
		.other-item{
			width: 120rpx;
			margin: 10rpx 30rpx;
			display: flex;
			flex-direction: column;
			justify-content: space-around;
			align-items: center;
			.other-img-content{
				background-color: #fff;
				border-radius: 5px;
				width: 120rpx;
				height: 120rpx;
				display: flex;
				align-items: center;
				justify-content: center;
				.other-img{
					width: 70rpx;
				}
			}
			.other-text{
				margin-top: 10rpx;
				font-size: 12px;
			}
		}
	}
}
</style>
