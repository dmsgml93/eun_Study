FROM node:18.17.1 AS build

#/usr/src로 이동
WORKDIR /app

# package 복사
COPY /my-app/package*.json /my-app/yarn.lock ./
RUN yarn install
#파일전체복사
COPY /my-app .
RUN yarn build
ADD test.sh ./
RUN chmod +x ./test.sh
FROM node:18.17.1  AS runner
WORKDIR /app



COPY --from=build /app/package*.json ./
COPY --from=build /app/yarn.lock ./
COPY --from=build /app/public ./public
COPY --from=build /app/.next/static ./.next/static
COPY --from=build /app/ ./
# 운영환경 Install
RUN yarn install --production 
EXPOSE 3000
CMD ["./test.sh"]
#CMD ["yarn", "start"]