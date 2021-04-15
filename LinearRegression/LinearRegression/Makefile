# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: widraugr <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/11/29 13:07:44 by widraugr          #+#    #+#              #
#    Updated: 2021/04/15 15:37:54 by mixfon           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME_LR = ft_linear_regression
NAME_FORECAST = forecast

FILE_LR = LinearRegression.swift\
		  main.swift

FILE_FORECAST = ../Forecast/Forecast.swift\
				../Forecast/main.swift

all : $(NAME_LR) 

$(NAME_LR): 
	swiftc $(FILE_LR) -o $(NAME_LR)
	swiftc $(FILE_FORECAST) -o $(NAME_FORECAST)

clean:
	/bin/rm -f $(NAME_LR)
	/bin/rm -f $(NAME_FORECAST)
	/bin/rm -f rezult.csv
	
re: clean all 
