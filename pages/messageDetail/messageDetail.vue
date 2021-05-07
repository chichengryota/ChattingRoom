<template>
	<view>
		<navbar :type="2" title="动态详情"></navbar>
		<view class="message-item">
			<chat-message-item :messageData="messageData" @change-follow="changeFollow($event)"></chat-message-item>
		</view>
		<view class="message-comment">
			<view class="message-comment-item" v-for="(item,index) in comments" :key="index">
				<image :src="item.avatar" mode="" class="comment-avatar"></image>
				<view class="comment-right">
					<view class="comment-name">{{item.name}}</view>
					<view class="comment-content">
						{{item.comment}}
					</view>
					<view class="comment-children">
						<view class="comment-children-item" v-for="(item1,index1) in item.children" :key="index1">
							<text class="comment-children-name">{{item1.name+'：'}}</text>
							<text>{{item1.comment}}</text>
						</view>
					</view>
					<view class="comment-bottom">
						<text class="comment-time">{{item.time | date('mm-dd hh:MM')}}</text>
							<image src="../../static/image/comment.png" mode="" class="bottom-icon icon-comment"></image>
							<image src="../../static/image/like.png" mode="" class="bottom-icon" v-show="item.isLike==1"></image>
							<image src="../../static/image/unlike.png" mode="" class="bottom-icon" v-show="item.isLike==0"></image>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				messageData:{},
				comments:[{
					avatar:'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
					name:'风过有痕',
					comment:'渐生情愫去神农架你是带你玩你的那是你呢',
					time:1614689655857,
					isLike: 0,
					children:[{
						name:'大晚上的',
						comment:'到网上大多多撒三点定位群多啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊'
					},{
						name:'大晚上的',
						comment:'到网上大多多撒三点定位群多'
					}]
				},{
					avatar:'http://browser9.qhimg.com/bdm/800_450_85/t010769fafba59eb5c4.jpg',
					name:'带我去无多',
					comment:'阿诗丹顿渐生情愫去神农架你是带你玩你的那是你呢',
					time:1614689655857,
					isLike: 1,
					children:[{
						name:'as是的撒',
						comment:'到网上大多多撒三点定位群多'
					},{
						name:'大晚上的',
						comment:'到网上大多多撒三点定位群多'
					}]
				}]
			}
		},
		onLoad(option) {
			this.messageData = JSON.parse(option.data)
		},
		methods: {
			// 更改关注状态
			changeFollow(id){
				this.messageData.isFollow = !this.messageData.isFollow;
			},
		}
	}
</script>

<style lang="scss" scoped>
.message-item{
	margin-bottom: 20rpx;
	background-color: #fff;
	padding: 0 30rpx;
	padding-top: 20rpx;
	display: flex;
	flex-direction: column;
}
.message-comment{
	padding: 10rpx 0;
	width: 100%;
	.message-comment-item{
		display: flex;
		border-bottom: 1px solid #eee;
		padding: 30rpx 0;
		.comment-avatar{
			width: 90rpx;
			height: 90rpx;
			border-radius: 50%;
			margin: 0 30rpx;
		}
		.comment-right{
			width: 570rpx;
			display: flex;
			flex-direction: column;
			.comment-name{
				font-size: 14px;
				font-weight: bold;
				color: $theme-color;
				margin-bottom: 10rpx;
			}
			.comment-content{
				font-size: 16px;
				line-height: 44rpx;
			}
			.comment-children{
				background-color: #eee;
				padding: 10rpx 20rpx;
				font-size: 14px;
				margin: 16rpx 0;
				.comment-children-item{
					margin-bottom: 10rpx;
					line-height: 44rpx;
					.comment-children-name{
						color: $theme-color;
					}
				}
			}
			.comment-bottom{
				display: flex;
				justify-content: space-between;
				align-items: center;
				.comment-time{
					font-size: 12px;
					color: #888;
				}
				.bottom-icon{
					width: 34rpx;
					height: 34rpx;
				}
				.icon-comment{
					margin-left: 280rpx;
				}
			}
		}
	}
}
</style>
